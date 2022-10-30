#include <stdio.h>
#include <math.h>

int is_prime(int num){
	int  flag =0;
	//This excludes 0 and 1 from being counted as prime numbers.
	if (num == 0 || num == 1){
		flag = 1;
	}

  for (int i = 2; i <= num / 2; i++) {
    if (num % i == 0) {
		//if num has other multiples rather than 1 and itself.
		flag = 1;
		return 0;
    }
  }
  if(flag != 1){
	//else that number is prime.
    return 1;
	}
}

int reverse_num(int num){
	int  rev = 0, rem = 0;
							//Example				iteration 2			iteration 3
	while(num != 0){		//num = 501				num = 50			num = 5
		rem = num%10;		//501%10 = 1 = rem		50%10 = 0 = rem		5%10 = 5 = rem
		rev = rev*10 + rem;	//rev = 0*10 +1 = 1;	rev = 1*10 +0 = 10;	rev = 10*10 +5 = 105 
		num/=10;			//501/10 = 50			50/10 = 5			5/10 = 0 => END OF LOOP
	}
	return rev;
}

int is_sqr(int num){
	int root = sqrt(num); 

    if (root * root == num)
        return 1;
    else
        return 0;
}

int is_sqrofaprime(int num){

	if(is_sqr(num)){
		//checks if the square root of num is a prime integer.
		if(is_prime(sqrt(num)))
			return 1;
	}
	return 0;
}


int  is_palindrome(int num){
	if(num == reverse_num(num)){
		return 1;
	}
	return 0;	
}

int rev_is_sqrofaprime(int num){
	
	if(is_sqrofaprime(reverse_num(num)))
		return 1;
	else
		return 0;	
}

int main(void)
{
	int count = 0, x = 0;
	while(count < 10){
		if(!is_palindrome(x)){
			if(is_sqrofaprime(x)){
				if(rev_is_sqrofaprime(x)){
					printf("%d\n",x);
					/*increaments only if arbitrary number 'x' meets the given criteria,
					which means the loop will terminate when count == 10*/
					count++;
				}
			}
		}
		x++;				
	}
	printf("Hello world!");
	return 0;
}