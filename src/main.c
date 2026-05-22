#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <unistd.h>
#include <ctype.h>
#include <sys/stat.h>

#define BUILTIN_COUNT 4
#define PATH_MAX 4096
#ifdef _WIN32
#define PATH_SEPARATOR ";"
#else
#define PATH_SEPARATOR ":"
#endif

const char *builtins[] = {"echo", "pwd", "type", "exit"};

char *findExecutable(char *command)
{
  char *s = strdup(getenv("PATH"));
  char *paths[20];
  int i = 0;
  while ((paths[i] = strsep(&s, PATH_SEPARATOR)) != NULL)
  {
    char exePath[2048];
    snprintf(exePath, sizeof(exePath), "%s/%s", paths[i], command);
    if (access(exePath, X_OK) == 0)
    {
      char *foundPath = malloc(strlen(exePath) * 10);
      foundPath = exePath;
      return foundPath;
    }
    i++;
  }
  return 0;
}

bool echo(char *input)
{
  if (!(strncmp(input, "echo", 4) == 0))
    return 0;
  if (!(strlen(input) > 5))
    return 0;
  printf("%s\n", input + 5);
  return 1;
}

void trim(char *s)
{
  char *p = s;
  int l = strlen(p);
  while (isspace(p[l - 1]))
    p[--l] = 0;
  while (*p && isspace(*p))
    ++p, --l;
  memmove(s, p, l + 1);
}

/*
Checks if command is cd and executes it
*/
bool chdirCmd(char *input)
{
  if (!strncmp(input, "cd", 2) == 0)
  {
    return 0;
  }
  if (!(strlen(input) > 3))
  {
    return 0;
  }
  char* pathCpy = strdup(strchr(input, ' '));
  trim(pathCpy);
  if (chdir(pathCpy) == 0) {
    return 1;
  } else {
    char* home_dir = getenv("HOME");
    if (strcmp(pathCpy, "~") == 0) {
      chdir(home_dir);
      return 1;
    }
    printf("cd: %s: No such file or directory\n", pathCpy);
    return 1;
  }
}

/*
Checks if command is type and executes it
*/
bool type(char *input)
{
  if (!strncmp(input, "type", 4) == 0)
    return 0;
  if (!(strlen(input) > 5))
    return 0;
  // we know it's a type command
  char *command_copy = strdup(strchr(input, ' '));
  trim(command_copy); // trims the command
  for (int i = 0; i < BUILTIN_COUNT; i++)
  {
    if (strcmp(command_copy, builtins[i]) == 0)
    {
      printf("%s is a shell builtin\n", command_copy);
      return 1; // match fou4d
    }
  }
  char *exePath = findExecutable(command_copy);
  if (exePath)
  {
    printf("%s is %s\n", command_copy, exePath);
    return 1;
  }
  printf("%s: not found\n", command_copy);
  return 1;
}

/*
Checks if command is command and executes it
 */
bool command(char *input)
{
  char *command = strchr(input, ' ');
  char *command_copy;
  if (command != NULL)
  {
    size_t len = command - input; // length before space
    command_copy = strndup(input, len);
  }
  else
  {
    command_copy = strdup(input);
  }
  char *exePath = findExecutable(command_copy);

  if (exePath)
  {
    system(input);
    return 1;
  }
  return 0;
}

/*
Check if command is pwd and executes it
*/
bool pwd(char *input)
{
  trim(input);
  if (strstr(input, "pwd"))
  {
    char buf[PATH_MAX];
    getcwd(buf, 1024);
    printf("%s\n", buf);
    return 1;
  }
  return 0;
}

int main()
{
  while (1)
  {
    // Flush after every printf
    setbuf(stdout, NULL);
    // TODO: Uncomment the code below to pass the first stage
    printf("$ ");
    char input[64];
    fgets(input, sizeof(input), stdin);
    input[strcspn(input, "\n")] = '\0';
    if (strcmp(input, "exit") == 0)
    {
      exit(0);
    }
    bool isChdir = chdirCmd(input);
    if (isChdir)
      continue;
    bool isEcho = echo(input);
    if (isEcho)
      continue;
    bool isType = type(input);
    if (isType)
      continue;
    bool isPwd = pwd(input);
    if (isPwd)
      continue;
    bool isCommand = command(input);
    if (isCommand)
      continue;
    printf("%s: command not found\n", input);
  }
}
