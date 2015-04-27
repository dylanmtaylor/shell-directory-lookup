#!/bin/bash
#Written by Dylan Taylor

#first things first... let's check for the existence of the data file
if [ -f "datafile" ]; then 
	#our data file exists. that's a good thing.
	echo "The data file exists. :-)"; echo
else
	echo "No data file found, so I created one for you."; echo; #let's make a new, empty data file
	touch datafile
fi

#we declare our functions up here...
function add_entry() {
	echo -e "\nCreating new entry. Please enter the necessary information.\n"
	echo "Enter first and last name: "; read name
	count=`grep -ci "$name" datafile` 
	if [ $count -gt 0 ]; then
		echo -e "\nThe file already contains this name.\n"
	else
		#echo "$name:" >> datafile
		echo "Enter phone number: "; read phone
		#echo "$phone:" >> datafile
		echo "Enter address:"; read addr
		echo "Writing to file..."
		echo "$name:$phone:$addr" >> datafile
		echo "Writing complete."
	fi
	echo; CHOICE=0 #main_menu
}

function delete_entry() {
	echo "Who would you like to delete?"
	read del_name
 	count=`grep -ci "$del_name" datafile`
        if [ $count -lt 1 ]; then
                echo -e "\nThe file does not contain this name.\n"
        else
        	echo "Deleting..."
	        removed=`grep -vi "$del_name" datafile`
		echo "Writing to file..."
		echo $removed > datafile;
		echo "Deletion complete."
	fi
	echo; CHOICE=0 #main_menu
}

function view_entry() {
	echo "View information for which person?"; read person
	if [ `grep -ci $person datafile` -gt 0 ]; then
		echo -e "\nDirectory Lookup:"; 
		#just practicing parsing data here, using a couple different methods
		lookup=`grep -i "$person" datafile | tr ":" "\n"`
		read lname <<< "$lookup"
		echo "Name: $lname"
		lphone=`grep -i "$person" datafile | cut -d':' -f2`
		echo "Phone: $lphone"
		laddr=`grep -i "$person" datafile | cut -d':' -f3`
		echo "Address: $laddr"
	else
		echo -e "\nThat person does not exist in the database."
	fi	
	#echo $lookup
	echo; CHOICE=0; #main_menu
}

CHOICE=0
#now, let's print out a menu

function main_menu() {
while [ $CHOICE -lt 1 -o $CHOICE -gt 4 ]; do
	echo "    MAIN MENU   "
	echo -e " ================== \n"
	echo "  1] Add Entry      "
	echo "  2] Delete Entry   "
	echo "  3] View Entry     "
	echo "  4] Exit           "
	echo -e "\nEnter Selection: "; read CHOICE
	case "$CHOICE" in
		1 ) add_entry;;
		2 ) delete_entry;;
		3 ) view_entry;;
		4 ) echo "Goodbye!"; exit 0;;
		* ) echo -e "Invalid selection.\n"; CHOICE=0;;
	esac 
done
}

main_menu
exit 0

