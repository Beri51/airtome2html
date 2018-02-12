# airtome2html

This is essentially a web export for flight books created with airtome, see https://airtome.bitbucket.io/

Sample Output: https://sebschmied.github.io/flights

## How to use
Assuming debian/ubuntu or mac OS and bash:

* Get all the tools you need:
```bash
sudo apt update
sudo apt install git gpsbabel libsaxonb-java
```
or on mac OS:
```bash
brew update
brew install git gpsbabel saxon
```
### Setup
* [Fork](https://help.github.com/articles/fork-a-repo/#platform-linux) the project on github. You need to be able to push to the repo, so this is mandatory. I started this project in part because I wanted to use github as my flight log backup.
* Open a Terminal.
* [Clone](https://help.github.com/articles/cloning-a-repository/#platform-linux) your forked repo and ``cd`` there.
* Remove my flights: ``rm -rf ./flightbook``.
* copy your own *.fb.zip into the project's root folder.
* Edit ``airtome2html.config.sh``, see comments there.
* Run ``./push`` to unzip the .fb.zip, create the .kmz files, run the xslt transformation, copy the output  to your output directory, and commit to the repo. The first run will take quite a while, because .kmz files are created.

### Updating
* Run ``./get`` to pull from github and create a temporary .fb.zip file from the ``./flightbook/`` files. This will also try to open airtome.
* In airtome, open the .fb.zip manually if this is the first run, i.e. make sure it is the one stored in your repo folder and not your previous location.
* Make your changes, save the flightbook, close airtome
* Run ``./push`` to publish changes.`
* Don't commit/push manually if flight data is involved, because this would .gitignore any changes in the .fb.zip.

## Components:

### flightbook.xsl
An XSLT stylesheet that translates parts of the airtome xml format to fancy html.

### ./get:
* Git pull the repository and create a .fb.zip that can be opened and edited by airtome.
* Open airtome
* * Run ``sync-wwwdir.sh`` in case anything has changed in the .fb.zip.

### ./push
* Extract the .fb.zip (simply because git doesn't like binaries), 
* Run ``./igc2kmz``
* Run ``transform.sh``
* Run ``sync-wwwdir.sh``
* git add, commit and push everything that has changed

### ./transform
* Populate the stylesheet with the values set in ``airtome2html.config.sh`` and transform it to an index.html file.

### ./sync-wwwdir.sh
* Copy files to an output directory, if activated in ``airtome2html.config.sh``. This one is probably called more often then necessary because I let rsync decide whether something needs to be updated.

### ./igc2kmz
*  Loop through ``./flightbook/**`` to create .kmz files from .igc files where not yet done. This will also replace any spaces in .igc file names.
