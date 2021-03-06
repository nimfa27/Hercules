if [ "$#" -ne 1 ] 
then
	echo "usage: sh $0 <project_name>"
	exit 0
else
	PROJECT=$(echo "$1" )
	echo "Creating project $PROJECT..."
fi
DIRECTORY=./$PROJECT
if [ ! -e $DIRECTORY ] 
then
	mkdir $DIRECTORY
	echo "Path of project: ${PWD/#$HOME/~}"/$PROJECT
else 
	echo "Directory <$PROJECT> already exist. Please choose another name and try again"
	exit 0
fi

while true
do
	read -p "For which programming language do you want to create files? (c/j) " cj
	case $cj in
		[Cc]* ) LG=$( echo "$cj" | tr '[:upper:]' '[:lower:]'); break;;
		[Jj]* ) LG=$( echo "$cj" ); break;;
		* ) echo "Please choose c or java (c/j)"
	esac
done
if [ $LG == "c" ]
then
	while true
	do
		read -p "Do you want to create author file? (y/n): " yn
		case $yn in
			[Yy]* ) echo $USER > $DIRECTORY/author; break;;
			[Nn]* ) break;;
			* ) echo "Please answer yes/no (y/n)"
		esac
	done

	while true
	do
		read -p "Do you want to include libft? (y/n): " yn
		case $yn in
			[Yy]* ) sh ./tools/include_libft.sh $DIRECTORY; FLAG=1; break;;
			[Nn]* ) FLAG=0; break;;
			* ) echo "Please answer yes/no (y/n)"
		esac
	done

	while true
	do
		read -p "Do you want to create a Makefile? (y/n): " yn
		case $yn in
			[Yy]* ) sh ./tools/create_makefile.sh $DIRECTORY $PROJECT $FLAG; break;;
			[Nn]* ) break;;
			* ) echo "Please answer yes/no (y/n)"
		esac
	done

	while true
	do
		read -p "Do you want to create .gitignore file? (y/n): " yn
		case $yn in
			[Yy]* ) sh ./tools/create_gitignore.sh $DIRECTORY; break;;
			[Nn]* ) break;;
			* ) echo "Please answer yes/no (y/n)"
		esac
	done
	echo "***c project <$( echo "$PROJECT" )> has been created successfully***"
else
	NAME=$PROJECT.java
	echo "public class $PROJECT {" > $DIRECTORY/$NAME
	echo '	public static void main (String [] args) {' >> $DIRECTORY/$NAME
	echo '' >> $DIRECTORY/$NAME
	echo '	}' >> $DIRECTORY/$NAME
	echo '}' >> $DIRECTORY/$NAME
	echo "***java project <$( echo "$PROJECT" )> has been created successfully***"	
fi
