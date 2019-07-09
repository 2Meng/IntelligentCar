
/*-------------------------------------------------------------------���㷨�������ʲ��ó���������---------------------------------------------------*/
#include <stdio.h>
#include <math.h>

//#define Use_Rows   60
//#define Use_Lines  96

#define X1 78
#define Y1 277
#define X2 57
#define Y2 239
#define X3 40
#define Y3 186

typedef unsigned char uchar;

double N1[8] = { -0.0150792895845385, 0.724790208254393, -133.828519072425, 0.479859245171029, -0.0390347367641871, 246.078939652662, 0.0367756477299942, -0.000217827161952334 };
double N2[8] = { 0.0478310147920351, 0.754572091335592, -145.273949103573, 0.542603428388435, -0.0236547096030482, 248.166384940324, 0.0381442174657022, 4.33612608899718e-05 };
double N3[8] = { 0.0574754213423609, 0.578968077433388, -111.751496059287, -0.0560155656710943, 0.0227855980674026, 213.356999095967, 0.0241698103008391, 0.000553684893374724 };


struct Loc
{
	double x;
	double y;
};

//int mid_line[Use_Rows] = { 18, 27, 38, 51, 55, 58, 59, 61, 61, 61, 61, 60, 59, 56, 55,
//						  54, 53, 51, 50, 48, 47, 45, 43, 43, 42, 42, 42, 41, 41, 41,
//						  41, 41, 41, 42, 42, 42, 42, 43, 43, 43, 43, 44, 44, 45, 45,
//						  45, 46, 46, 46, 47, 47, 48, 48, 48, 48, 48, 48, 48, 48, 48 };

double bianchang_Cal(double a, double b, double c, double d)  //�߳����㺯��,����Ϊ����
{
	double x;
	x = sqrt(fabs((a - c)*(a - c) + (b - d)*(b - d)));
	return x;
}

double Cal(double a, double b, double c, double s)   //���ʹ�ʽ����������Ϊ���߳������
{
	double x;
	x = 4 * s / (a*b*c);
	return x;
}

struct Loc Loc_change(int line, int col ) //����任������������&�У����ؽṹ��
{
	struct Loc Real_Loc; //ʵ������

	if (line < 70)
	{
		Real_Loc.x = (int)(N3[0] * line + N3[1] * col + N3[2]) / (N3[6] * line + N3[7] * col + 1);
		Real_Loc.y = (int)(N3[3] * line + N3[4] * col + N3[5]) / (N3[6] * line + N3[7] * col + 1);
	}

	else if (line > 110)
	{
		Real_Loc.x = (int)(N1[0] * line + N1[1] * col + N1[2]) / (N1[6] * line + N1[7] * col + 1);
		Real_Loc.y = (int)(N1[3] * line + N1[4] * col + N1[5]) / (N1[6] * line + N1[7] * col + 1);
	}
	
	else
	{
		Real_Loc.x = (int)(N2[0] * line + N2[1] * col + N2[2]) / (N2[6] * line + N2[7] * col + 1);
		Real_Loc.y = (int)(N2[3] * line + N2[4] * col + N2[5]) / (N2[6] * line + N2[7] * col + 1);
	}

	return Real_Loc;
}

double curvature_Cal(int x1, int y1, int x2, int y2, int x3, int y3) //���ʼ��㺯��
{
	double AB, BC, AC, S;
	double curvature;
	AB = bianchang_Cal(x1, y1, x2, y2);
	AC = bianchang_Cal(x1, y1, x3, y3);
	BC = bianchang_Cal(x2, y2, x3, y3);
	S = abs((x2 - x1)*(y3 - y1) - (x3 - x1)*(y2 - y1)) / 2;  //���㹹�ɵ����������

	curvature = Cal(AB, AC, BC, S);

	return curvature;
}

struct Loc midline_Loc(double x, double y, double R) //�������Ϊ���������ǰ���������ʰ뾶����������ߵ�����������ƫ��ǣ�������ֻ��������������
{
	struct Loc mid_Loc;
	double k = (R - 22.5) / R;
	double sin = y / R;
	
	//mid_Loc.x = fabs(x) + 22.5 * sqrt( 1 - sin*sin  );

	if (x < 0)
	{
		mid_Loc.x = x - 22.5 * sqrt(1 - sin * sin);
	}

	else 
		mid_Loc.x = x + 22.5 * sqrt(1 - sin * sin);
	mid_Loc.y = y * k;

	return mid_Loc;
}

double Ackman_R(double x, double y)
{
	double R;

	R = (x*x + y * y) / (2 * y);

	return R;
}

int main(void)
{
	double cur;//����
	double R;   //�뾶
	double x1, y1, x2, y2, x3, y3; //��������

	x1 = Loc_change(X1, Y1).x;
	y1 = Loc_change(X1, Y1).y;

	x2 = Loc_change(X2, Y2).x;
	y2 = Loc_change(X2, Y2).y;

	x3 = Loc_change(X3, Y3).x;
	y3 = Loc_change(X3, Y3).y;

	cur = curvature_Cal(x1, y1, x2, y2, x3, y3);

	R = 1 / cur;

	printf("x1 = %lf y1 = %lf\nx2 = %lf y2 = %lf\nx3 = %lf y3 = %lf\nǰհ�����ǣ�%lf\n��·�뾶R = %lf", x1, y1, x2, y2, x3, y3 ,cur, R);
	getchar();

	return 0;
}
















/*-------------------------------------------------------------------���㷨�������ʲ��ó���������---------------------------------------------------*/
#include "system.h"




#define X1 78
#define Y1 277
#define X2 57
#define Y2 239
#define X3 40
#define Y3 186



double N1[8] = { -0.0150792895845385, 0.724790208254393, -133.828519072425, 0.479859245171029, -0.0390347367641871, 246.078939652662, 0.0367756477299942, -0.000217827161952334 };
double N2[8] = { 0.0478310147920351, 0.754572091335592, -145.273949103573, 0.542603428388435, -0.0236547096030482, 248.166384940324, 0.0381442174657022, 4.33612608899718e-05 };
double N3[8] = { 0.0574754213423609, 0.578968077433388, -111.751496059287, -0.0560155656710943, 0.0227855980674026, 213.356999095967, 0.0241698103008391, 0.000553684893374724 };


//int mid_line[Use_Rows] = { 18, 27, 38, 51, 55, 58, 59, 61, 61, 61, 61, 60, 59, 56, 55,
//						  54, 53, 51, 50, 48, 47, 45, 43, 43, 42, 42, 42, 41, 41, 41,
//						  41, 41, 41, 42, 42, 42, 42, 43, 43, 43, 43, 44, 44, 45, 45,
//						  45, 46, 46, 46, 47, 47, 48, 48, 48, 48, 48, 48, 48, 48, 48 };

double bianchang_Cal(double a, double b, double c, double d)  //�߳����㺯��,����Ϊ����
{
	double x;
	x = sqrt(fabs((a - c)*(a - c) + (b - d)*(b - d)));
	return x;
}

double Cal(double a, double b, double c, double s)   //���ʹ�ʽ����������Ϊ���߳������
{
	double x;
	x = 4 * s / (a*b*c);
	return x;
}

point_t locaion_transform(int line, int col) //����任������������&�У����ؽṹ��
{
	struct Loc Real_Loc; //ʵ������

	if (line < 70)
	{
		Real_Loc.x = (int)(N3[0] * line + N3[1] * col + N3[2]) / (N3[6] * line + N3[7] * col + 1);
		Real_Loc.y = (int)(N3[3] * line + N3[4] * col + N3[5]) / (N3[6] * line + N3[7] * col + 1);
	}

	else if (line > 110)
	{
		Real_Loc.x = (int)(N1[0] * line + N1[1] * col + N1[2]) / (N1[6] * line + N1[7] * col + 1);
		Real_Loc.y = (int)(N1[3] * line + N1[4] * col + N1[5]) / (N1[6] * line + N1[7] * col + 1);
	}

	else
	{
		Real_Loc.x = (int)(N2[0] * line + N2[1] * col + N2[2]) / (N2[6] * line + N2[7] * col + 1);
		Real_Loc.y = (int)(N2[3] * line + N2[4] * col + N2[5]) / (N2[6] * line + N2[7] * col + 1);
	}

	return Real_Loc;
}

double curvature_Cal(point_t A, point_t B, point_t C) //���ʼ��㺯��
{
	uint16_t x1, y1, x2, y2, x3, y3;
	x1 = A.x;
	y1 = A.y;
	x2 = B.x;
	y2 = B.y;	
	x3 = C.x;
	y3 = C.y;

	double AB, BC, AC, S;
	double curvature;
	AB = bianchang_Cal(x1, y1, x2, y2);
	AC = bianchang_Cal(x1, y1, x3, y3);
	BC = bianchang_Cal(x2, y2, x3, y3);
	S = abs((x2 - x1)*(y3 - y1) - (x3 - x1)*(y2 - y1)) / 2;  //���㹹�ɵ����������

	curvature = Cal(AB, AC, BC, S);

	return curvature;
}

point_t midline_Loc(double x, double y, double R) //�������Ϊ���������ǰ���������ʰ뾶����������ߵ�����������ƫ��ǣ�������ֻ��������������
{
	point_t mid_Loc;
	double k = (R - 22.5) / R;
	double sin = y / R;

	//mid_Loc.x = fabs(x) + 22.5 * sqrt( 1 - sin*sin  );

	if (x < 0)
	{
		mid_Loc.x = x - 22.5 * sqrt(1 - sin * sin);
	}

	else
		mid_Loc.x = x + 22.5 * sqrt(1 - sin * sin);
	mid_Loc.y = y * k;

	return mid_Loc;
}

double Ackman_R(double x, double y)
{
	double R;

	R = (x*x + y * y) / (2 * y);

	return R;
}

int main(void)
{
	double cur;//����
	double R;   //�뾶

	point_t A, B, C;
	A = locaion_transform(X1, Y1);
	B = locaion_transform(X2, Y2);
	C = locaion_transform(X3, Y3);

	cur = curvature_Cal(A, B, C);

	R = 1 / cur;

	printf("x1 = %lf y1 = %lf\nx2 = %lf y2 = %lf\nx3 = %lf y3 = %lf\nǰհ�����ǣ�%lf\n��·�뾶R = %lf", A.x, A.y, B.x, B.y, C.x, C.y, cur, R);
	getchar();

	return 0;
}


