int main(){

    int int_1 = 23; //NULL
    float float_1 = 4.8;
    float_1++;
    print(int_1);
    int_1 = 52; //52
    print(float_1);
    print(int_1);
    printf("Hello");
    printf("############################################");

    //Stop
    //int_1 = 52 -> data int_1 52

    int a = 8;
    int b;
    b = a + 1; // b = 9
    int c = 5*b;
    c++;
    a = b - a; // a = -1
    a = (c / 2) + (b * a) + c;
    int d = (a*5) - 6;
    print(a);
    print(b);
    print(c);
    print(d);

    return 0;
}
