//
// Created by Dell on 12/2/2021.
//

#ifndef SAATY_APP_TES_H
#define SAATY_APP_TES_H



class Tes {
#include<iostream>
#include <cmath>
using namespace std;
float areaOfSquare(float);
float perimeterOfSquare(float);
float areaOfTriagle(float , float , float );
float perOfTriangle(float , float,float);
float areaOfRectangle(float, float);
float perOfRectangle(float, float);

int main()
{
    float len, area,perimeter,breadth,height;
    char type;
     cout<<"Enter the type of shape: ";
    cin>>type;

    if(type == 's'){
         cout<<"Enter the Length of Square: ";
    cin>>len;
     area = areaOfSquare(len);
     perimeter = perimeterOfSquare(len);
    cout<<"\nArea = "<<area;
      cout<<"\nPerimeter = "<<perimeter;
    }else if (type == 't'){
         cout<<"Enter the Length of Square: ";
    cin>>len;
         cout<<"Enter the breadth of Triangle: ";
            cin>>breadth;
             cout<<"Enter the height of Triangle: ";
            cin>>height;
        area=areaOfTriagle(len , breadth , height );
        perimeter=perOfTriangle(len , breadth , height);

         cout<<"\nArea = "<<area;
       cout<<"\nPerimeter = "<<perimeter;

    }else if(type =='r'){
         cout<<"Enter the Length of Rectangle: ";
    cin>>len;
       cout<<"Enter the breadth of Rectangle: ";
    cin>>breadth;
     area=areaOfRectangle(len , breadth);
        perimeter=perOfRectangle(len , breadth);

         cout<<"\nArea = "<<area;
       cout<<"\nPerimeter = "<<perimeter;

    }

    cout<<endl;
    return 0;
}
float areaOfSquare(float len)
{
    return (len*len);
}

float perimeterOfSquare(float len)
{
    return (4*len);
}

float areaOfTriagle(float a, float b, float c)
{
    float s, ar;
    s = (a+b+c)/2;
    ar = sqrt(s*(s-a)*(s-b)*(s-c));
    return ar;
}
float perOfTriangle(float a, float b, float c)
{
    return (a+b+c);
}

float areaOfRectangle(float len, float bre)
{
    return (len*bre);
}

float perOfRectangle(float len, float bre)
{
    return (2*(len+bre));
}
};



#endif //SAATY_APP_TES_H
