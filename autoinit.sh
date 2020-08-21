#! /bin/bash

#For the colors
RED='\033[0;31m'
NC='\033[0m'

#Initiating the configaration file 
source autoinit.config

flutter_project_route="$flutter_default_route"
pyhton_project_route="$pyhton_default_route"


sample_flutter_route="$PWD/flutter"
sample_python_route="$PWD/python"

git_route=0


#Taking in the arguments.....
for args in "$@"
do
    case $args in
        -h|--help)
            cat help.txt
            shift
            ;;

        -n|--name)
            project_name="$2"
            echo "Setting project name as $2..."
            shift 
            shift
            ;;

        -c|--create)
            if [ -z "$project_name" ]
            then
                echo -e "${RED}Error: Project name cannot be null...${NC}"
            else
                echo "Creating you blank $2 project"

                case $2 in 
                    flutter)
                        cd $flutter_project_route
                        mkdir $project_name
                        cd $flutter_project_route$project_name
                        project_name_lo=$( echo $project_name | tr [:upper:] [:lower:] | tr [:space:] '_')
                        project_name_lo="${project_name_lo:0:${#project_name_lo}-1}"

                        if [ $WSL -eq "1" ]
                        then
                            echo "Performing updrage...(This might take a while)"
                            cmd.exe /C flutter upgrade

                            echo "Creating project....."
                            cmd.exe /C flutter create $project_name_lo
                        else
                            echo "Performing updrage...(This might take a while)"
                            flutter upgrade

                            echo "Creating project....."
                            flutter create $project_name_lo
                        fi
                        
                        cd $project_name_lo
                        echo "Repalcing the present sample project with a blank project..."
                        rm -rf lib/
                        cp -r "$sample_flutter_route/lib/" "$flutter_project_route$project_name/$project_name_lo"
                        echo "Creating the assets tree...." 
                        mkdir -p assets/images && mkdir -p assets/icons && mkdir -p assets/fonts
                        echo "Clearing the Pubspec..."
                        rm $flutter_project_route$project_name/$project_name_lo/pubspec.yaml

                        #To make a pepspec specific to the project
                        cd $sample_flutter_route
                        touch pubspec.yaml

                        export sample=$project_name_lo
                        (
                            echo "cat << EOF >pubspec.yaml"
                            cat pubspec_sample.yaml
                            echo -e "\nEOF"
                        ) >temp.sh
                        ./temp.sh
                        rm -rf temp.sh

                        mv -v "$sample_flutter_route/pubspec.yaml" $flutter_project_route$project_name/$project_name_lo/pubspec.yaml

                        #cd test

                        #export sample=$project_name_lo
                        #(
                            #echo "cat << EOF >widget_test.dart"
                            #cat widget_test_sample.dart
                            #echo -e "\nEOF"
                        #) >test_temp.sh
                        #./test_temp.sh
                        #rm -rf test_temp.sh

                        #mv -v "$sample_flutter_route/test/widget_test.dart" $flutter_project_route$project_name_lo/test/widget_test.dart
                        
                        #cd $flutter_project_route$project_name/$project_name_lo

                        git_route=1

                        #To open the VScode
                        if [ $vscode -eq "1" ]
                        then
                            if [ $WSL -eq "1" ]
                            then
                                cmd.exe /C code .
                            else
                                code .
                            fi
                        fi
                        ;;

                    python-venv)
                        
                        cd $pyhton_project_route
                        mkdir -p $project_name
                        cd $project_name

                        if [ $WSL -eq "1" ]
                        then 
                            cmd.exe /C python -m venv env                       
                        else
                            python -m venv env
                        fi

                        cp $sample_python_route/initiation $pyhton_project_route$project_name
                        

                        if [ $WSL -eq "1" ]
                        then 
                            cmd.exe /C code .                       
                        else
                            code .                        
                        fi

                        git_route=2
                        ;;

                    flutter-web)
                        
                        cd $flutter_project_route
                        mkdir $project_name
                        cd $flutter_project_route$project_name

                        project_name_lo=$( echo $project_name | tr [:upper:] [:lower:] | tr [:space:] '_' ) 

                        if [ $WSL -eq "1" ]
                        then
                            echo "Performing updrage...(This might take a while)"
                            cmd.exe /C flutter upgrade

                            echo "Creating project....."
                            cmd.exe /C flutter config --enable-web
                            cmd.exe /C flutter create $project_name_lo
                        else
                            echo "Performing updrage...(This might take a while)"
                            flutter upgrade

                            echo "Creating project....."
                            flutter config --enable-web
                            flutter create $project_name_lo
                        fi
                        
                        cd $project_name_lo
                        echo "Repalcing the present sample project with a blank project..."
                        rm -rf lib/
                        cp -r "$sample_flutter_route/lib/" "$flutter_project_route$project_name/$project_name_lo"
                        echo "Creating the assets tree...." 
                        mkdir -p assets/images && mkdir -p assets/icons && mkdir -p assets/fonts
                        echo "Clearing the Pubspec..."
                        rm -rf $flutter_project_route$project_name/$project_name_lo/pubspec.yaml

                        #To make a pepspec specific to the project
                        cd $sample_flutter_route
                        touch pubspec.yaml

                        export sample=$project_name_lo
                        (
                            echo "cat << EOF >pubspec.yaml"
                            cat pubspec_sample.yaml
                            echo -e "\nEOF"
                        ) >temp.sh
                        ./temp.sh
                        rm -rf temp.sh

                        mv -v "$sample_flutter_route/pubspec.yaml" "$flutter_project_route$project_name/$project_name_lo/pubspec.yaml"

                        git_route=1

                        if [ $WSL -eq "1" ]
                        then
                            cmd.exe /C flutter config --enable-web
                        else
                            flutter config --enable-web
                        fi

                        #To open the VScode
                        if [ $vscode -eq "1" ]
                        then
                            if [ $WSL -eq "1" ]
                            then
                                cmd.exe /C code .
                            else
                                code .
                            fi
                        fi

                        ;;

                    *)
                        echo -e "${RED}Error: Progamme does not recognaize this type of project...${NC}"
                        ;;
                esac
            fi
            shift
            shift
            ;;
        
        -g|--git-enable)
            case $git_route in
                0)
                    echo -e "${RED}Error: Path to the project folder was not found...${NC}"  
                    ;;
                1)
                    cd $flutter_project_route$project_name
                    git init
                    touch .gitignore
                    ;;
                2)
                    cd $pyhton_project_route$project_name
                    git init
                    touch .gitignore
                    ;;
            esac
            shift
            ;;

        -b|--banner)
            cat banner.txt
            shift
            ;;

        #*)
            #echo -e "${RED}Error: $1 command does not exist${NC}"
            #echo "Try the following to know more :"
            #echo "Autoinit -h <OR> autoinit --help"
            #shift
            #;;
    esac
done