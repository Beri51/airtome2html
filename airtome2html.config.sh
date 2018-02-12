# Airtome
flightbookfilename="flugbuch" # Your flightbook's file name, without the .fb.zip part
airtomebin="/opt/airtome/AirTome" #Your AirTome executable

# Website

copytooutputdirectory=true # Copy output website files to a local directory, e.g. /var/www/html/?
outputdir="${HOME}/git/sebschmied.github.io/flights" # The local path to store your website at, if copytooutputdirectory is set to true. If false, the script's working directory will be used instead.
websiteroot="https://sebschmied.github.io" # The website you're publishing on
kmzroot="https://github.com/sebschmied/sebschmied.github.io/blob/master/flights" # Root folder used for the .kmz files. In this case, I use the github tree instead of the github.io proxy, because there are some syncing issues. Set to "" (empty string) if the kmz directory doesn't differ from your website.
websitetitle="Flugbuch" # The big h2 headline and title tag
googlemapsapikey="AIzaSyB1CqtckRTi90FYDLfUjuUIydnPzoJzmiI" # Get your api key here: https://developers.google.com/maps/documentation/javascript/get-api-key
latitude="48.764444" # initial position of map before any flight is selected
longitude="8.280556" # Probably use your home site or something.
jqueryfile="jquery-3.3.1.min.js"

## Column titles
columntitle_number="Flug"
columntitle_date="Datum"
columntitle_aircraft="Schirm"
columntitle_distance="Strecke"
columntitle_site="Fluggebiet"
columntitle_duration="Dauer"
columntitle_comment="Kommentar"

# Maps
maps_line_color="ee0000ff"  #The line color to use for your track
maps_line_width="4"         # The line width 
maps_points_count="22000"   # Maximum number of track points. 22000 is enough to fully cover a 6 hour flight in 1.1 MB (igc + kmz), reduce this if disk space is an issue.

# Pilot data
minimum_xc_distance="15000" # Minimum xc distance in meters to display the distance at all. This is because I don't care about the distance for local soaring etc. Set to 0 if you do.

### Dont't edit below this line
if [ "${kmzroot}" == "" ]; then
    kmzroot=${websiteroot}
    outputdir=${PWD}
fi

if command -v saxonb-xslt > /dev/null; then
    saxoncommand=$(which saxonb-xslt)
else
    if command -v saxon > /dev/null; then
        saxoncommand=$(which saxon)
    else
        echo "No XSLT processor found. Please install saxon."
        exit 1
    fi
fi

if [ ! -f ${airtomebin} ]; then
    if [ -d /Applications/AirTome.app ]; then #mac os
        airtomebin="open /Applications/AirTome.app"
    else
        echo "Please set the airtomebin path in airtome2html.config.sh"
    fi
fi
