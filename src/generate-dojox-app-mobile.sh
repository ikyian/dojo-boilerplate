TEMPLATE_NAME=01-dojox-app-mobile
TEMPLATES_DIR=00-templates
TEMPLATE_DIR=${TEMPLATES_DIR}/${TEMPLATE_NAME}

function help {
	echo "Generator of dojox/app with dojox/mobile UI"
	echo "Usage: "
	echo "\t$0 <app-dir-name>"
	exit 0
}

if [[ "$#" != "1" ]] ; then
	echo "Error: not specified name of application the application folder."
	help
fi

if [[ -d "$1" ]] ; then
	echo "The folder with name '$1' already exists. Exiting"
	exit 1
fi

cat "${TEMPLATES_DIR}/${TEMPLATE_NAME}.html" | sed "s/{{app-name}}/$1/g" > "$1.html"
mkdir $1
cat "${TEMPLATE_DIR}/main.js" | sed "s/{{app-name}}/$1/g" > "$1/main.js"
cat "${TEMPLATE_DIR}/config.json" | sed "s/{{app-name}}/$1/g" > "$1/config.json"

mkdir $1/resources
cp "${TEMPLATE_DIR}/resources/styles.css" "$1/resources/styles.css"

mkdir $1/templates
cat "${TEMPLATE_DIR}/templates/home.html" | sed "s/{{app-name}}/$1/g" > "$1/templates/home.html"
cat "${TEMPLATE_DIR}/templates/page.html" | sed "s/{{app-name}}/$1/g" > "$1/templates/page.html"

mkdir $1/views
cp "${TEMPLATE_DIR}/views/home.js" "$1/views/home.js"
cp "${TEMPLATE_DIR}/views/page.js" "$1/views/page.js"


