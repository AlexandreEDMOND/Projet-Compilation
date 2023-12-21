int main()
{
  int a = 3;
  int b = 7;
  a++;
  for (int i = 0; i < 4; i++)
  {
    a = a * b;
  }

  int c = b / a;

  if (c > b)
  {
    a = 0;
  }
  else
  {
    a = 3;
  }

  while (a < 10)
  {
    a++;
  }

  return 0;
}