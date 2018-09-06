#!/bin/bash 


max=$( wc -l ~/amdict | awk '{print $1}' ) # Determine the max number of lines in the dictionary.
					   # This should be included in any script 
					   # using the randword() function.

randnum()
{
 	local rnvar=$(( $RANDOM%10 )) 	# Pick a number up to 10.
	echo "$rnvar"			# This is like a bash version of a return statement. 
}					# The value of $nvar will be the value of the function when expanded.
					# In short, the function can be called like this $(randnum).

randword()
{
   	local lnnum=$(( $RANDOM%$max )) # pick a random number that will correspond to a line/word in the dictionary.
   	echo "$( sed -n "$lnnum{p}" ~/amdict | awk -F"'" '{print $1}')" # return that line/word when the function is expanded.
}									# This function is meant to be called as the last one was.
									# IE: $(randword)


					#####-----------------------------------------------------------#####
					##### This is where things start to happen.			#####
					##### There's a for loop to make the parent directory. 		#####
					##### Then another with some nested loops to make the files.	#####
					#####-----------------------------------------------------------##### 


for i in {0..9}					# This is the for loop that makes parent directory
	do					# and the subdirectories to contain the files.
	mkdir -p testcontent/testdir"$i"	# The first iteration makes the top level directory
	done					# and the first subdirectory with the -p option
						# Subsequent iterations make the rest of the subs 

for j in {0..9}					# Here we start making files with random names 
	do					# that contain random word lists of random lengths.
		for k in {0..4}			# This line dictates that the next two variables will
						# be set 5 times (iterations 0-4) just as the upcoming
						# nested for loop will create 5 files per subdirectory.
			do
			name=$(randword)	# Dream up a file name with the randword function.
			lines=$(randnum)	# Designate a random number of lines for the file.
				for (( m=0 ; m <= lines ; m++ ))	# Loop through this bit once for each line.
				do 
				echo $(randword) >> testcontent/testdir"$j"/"$name".txt	# Create the file on the first 	
				done							# iteration and print random
			done								# words on each line.
	done										
											# And... We're done.
