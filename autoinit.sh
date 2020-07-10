#! /bin/bash

RED='\033[0;31m'
NC='\033[0m'

# put in your default paths for the projects
flutter_project_route="/mnt/c/Users/saswa/AndroidStudioProjects/"
pyhton_project_route="/mnt/e/Projects/"
sample_flutter_route="$PWD/flutter"

git_route=0

for args in "$@"
do
    case $args in
        -h|--help)
            cat ./help.txt
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


                        #for unix systems uncomment the next line
                        #flutter create $project_name_lo
                        
                        #for wsl systems uncomment the next line
                        cmd.exe /C flutter create $project_name_lo
                        
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
                            echo "cat <<EOF >pubspec.yaml"
                            cat pubspec_sample.yaml
                            echo "EOF"
                        ) >temp.sh
                        ./temp.sh
                        rm -rf temp.sh

                        mv -v "$sample_flutter_route/pubspec.yaml" $flutter_project_route$project_name/$project_name_lo/pubsec.yaml

                        git_route=1
                        ;;

                    python)
                        cd $pyhton_project_route
                        mkdir -p $project_name
                        git_route=2
                        ;;

                    flutter-web)
                        
                        cd $flutter_project_route
                        mkdir $project_name
                        cd $flutter_project_route$project_name
                        project_name_lo=$( echo $project_name | tr [:upper:] [:lower:] | tr [:space:] '_') 


                        #for unix systems uncomment the next line
                        #flutter config --enable-web
                        #flutter create $project_name_lo

                        #for wsl systems uncomment the next line
                        cmd.exe /C flutter config --enable-web
                        cmd.exe /C flutter create $project_name_lo
                        
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
                            echo "cat <<EOF >pubspec.yaml"
                            cat pubspec_sample.yaml
                            echo "EOF"
                        ) >temp.sh
                        ./temp.sh
                        rm -rf temp.sh

                        mv -v "$sample_flutter_route/pubspec.yaml" "$flutter_project_route$project_name/$project_name_lo/pubsec.yaml"

                        git_route=1
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