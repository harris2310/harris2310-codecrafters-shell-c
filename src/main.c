#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool echo(char *input)
{
  if (!strncmp(input, "echo", 4) == 0)
    return 0;
  if (!strlen(input) > 5)
    return 0;
  printf("%s\n", input + 5);
  return 1;
}

int main(int argc, char *argv[])
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
    bool isEcho = echo(input);
    if (isEcho)
      continue;
    printf("%s: command not found\n", input);
  }
}
