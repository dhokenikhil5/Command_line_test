<<doc

Name          = Nikhil R Dhoke
Date          = 1 Nov 2022
Description   = Take a Test Through Command line InterFace
Sample input  = 2
Sample output = Welcome to Sign_up Page


#!/bin/bash
doc


function pattern_and_option()
{
echo
echo
echo "     **************************************************"
echo "     **************************************************"
echo "     ************* WELCOME TO TEST SITE ***************"
echo "     **************************************************"
echo "     **************************************************"
echo
echo
echo "1: Sign Up"
echo "2: Sign In"
echo "3: Exit"
echo
}

function Take_Test()
{
 echo "===================================="
 echo "|                                  |"
 echo "|         Welcome to Test          |"
 echo "|                                  |"
 echo "===================================="
 echo
 echo " Please Enter option A/B/C/D "
 echo 
 
 length_of_file=(`cat Questions.txt | wc -l`)

 for m in `seq 5 5 $length_of_file`
 do
     flag=0
     (cat Questions.txt | head -$m | tail -5) 
 
  
 for j in `seq 10 -1 1`
 do
     echo -ne "\rChoose option : $j \c "
     read -t 1 opt  
    
     if [ ${#opt} -gt 0 ]
     then 
        echo $opt >> user_Test_Response.csv
	flag=1 
	break
     fi
 done

     if [ $flag -eq 0 ]                              # IF USER DOESNT ENTER BEFORE 10 SECOND 
     then                                          # IF USER DOES ENTERS ANY OPT
	     opt="e"                                # OPTION WILL BE ASSIGNED TO e
       echo $opt >> user_Test_Response.csv        # store user option
       echo
     fi 

 done
 userans_array=(`cat user_Test_Response.csv`)     # collected all User answers in array
 key_array=(`cat correct_Ans.txt`)                # COLLECTED ALL ANSWERS IN KEY_ARRAY ARRAY

marks=0

for check in `seq 0 $((${#key_array[@]}-1))`
 do 
     
     if [ ${userans_array[$check]} == ${key_array[$check]} ]
     then
	 marks=$(($marks+1))
     fi
 done
echo
echo "Your Total Marks are " $marks
sed -i d user_Test_Response.csv


}

function Sign_up() {

     echo
     echo "===================================="
     echo "|                                  |"
     echo "|     WELCOME TO SIGN UP PAGE      |"
     echo "|                                  |"
     echo "===================================="
     echo


username_arr=(`cat username_db.csv`)
password_arr=(`cat password_db.csv`)

echo -n "Enter Your Username Please : "
read user_entered_name

flag=0

for i in `seq 0 ${#username_arr[@]}`
do
    if [ $user_entered_name = ${username_arr[$i]} ]
    then
	 echo "User Already Exist..!"
	 echo "Please go to Sign Up page "
	 echo "     Thank you..! 	 "
	 flag=1
	 echo
	 echo Redirecting to Sign in page
	 Sign_in
	 break
    fi
 done

         while [ $flag -eq 0 ]
	  do
	       read -p " Enter New Password: " new_pwd
	       read -p " Enter Confirm Password: " cnf_pwd

	       if [ $new_pwd == $cnf_pwd ]
	       then
                 (echo $user_entered_name) >> username_db.csv
		 (echo $cnf_pwd) >> password_db.csv
		  echo " Congrats..! You have Sucessfully Created account.. "
                  flag=1
		  Sign_in
		  break
	        else
		  echo " Password doesn't match Please Retry.. "
	       fi
           done

}

function Sign_in() {
     echo
     echo " __________________________________"
     echo "|                                  |"
     echo "|     WELCOME TO SIGN IN PAGE      |"
     echo "|                                  |"
     echo "|__________________________________|"

    echo 
    read -p " Enter your Username : " Sign_in_username1
  
    username_arry=(`cat username_db.csv`)
    password_arry=(`cat password_db.csv`)

    for j in `seq 0 ${#username_arry[@]}`
    do
	if [ $Sign_in_username1 = ${username_arry[$j]} ]
	then
             index=0
	    read -p " Enter Your Password: " Sign_in_password1
             
	      if [ $Sign_in_password1 = ${password_arry[$j]} ]
	      then
	        	echo Sign in Sucessfull
			echo
	        	echo -e " 1:Take Test   2:exit "
			echo
			echo " Enter Choice 1/2" 
			read cho

			if [ $cho -eq 1 ]
			then
		    	  Take_Test
			  break
                	else
	         	    Exit
	        	fi
	
	       else
	          echo " Incorrect Password.."
		  break
               fi
	   else
	    index=$(($index+1)) 
	    arr_len=$((${#username_arry[@]}))
	  
	    if [ $index -eq $arr_len ]
	    then
		echo " No Username Found..! Please Create Account. "
         	Sign_up
		break
	    fi
	fi
      
  done
}



function Exit() {

read -p "Do yo want Really want to Exit Y/N :" opt
if [ $opt == "y" -o $opt == "Y" -o $opt == "yes" -o $opt == "YES" -o $opt == "Yes" ]
then
    echo
    echo " -------------------------------------"
    echo "|                                     |"
    echo "|       Sorry to See you go..         |"
    echo "|                                     |"
    echo " -------------------------------------"
    echo
    echo
    return
else
    echo "Redirected to Sign_in page..."
    Sign_in 
fi


}




pattern_and_option

read -p "Enter Proper Option: " choice

case $choice in

    1)	Sign_up
	;;

    2)  Sign_in
	;;

    3)	Exit
	;;
    *)
	echo Enter Proper option
	;;
esac





























