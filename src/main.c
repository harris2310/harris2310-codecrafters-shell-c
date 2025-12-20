#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
    if (strncmp(input, "echo", 4) == 0)
    {
      if (strlen(input) > 5)
      {
        printf("%s\n", input + 5);
      }
      continue;
    }
    printf("%s: command not found\n", input);
  }
}
