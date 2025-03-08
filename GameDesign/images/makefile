
# Ensure "make" is using the Windows shell, instead of /usr/bin/sh which can happen if using some
# versions of "make" on PC (e.g. cygwin).
SHELL=C:\\Windows\\system32\\cmd.exe

.PHONY: umletConversion


# To build binary image files from UMLet sources the
# user/caller MUST specify the path of the
# umlet.jar file to launch UMLet from commandline.
# e.g., c:\tools\umlet
# This default makefile assumes the user has installed umlet and set an environment
# variable to the path.
UMLET = ${UMLET_PATH}

# Setup folders to parse for UMLet file conversion process
IMAGE_PATH=./src

# Need to provide make with paths to where pre-requisite files are so it can properly evaluate rules.
# Since make is not run from the same place where all the pre-requisite files are located the vpath needs
# to be setup.
VPATH = $(IMAGE_PATH)

# Setup where converted files will be stored.
IMAGE_OUTPUT_PATH=./

# Get a list of all umlet files in the path - note not recursive...
UMLET_IMAGES=$(wildcard $(IMAGE_PATH)/*.uxf)



# Convert the list of umlet files to the output filenames, stripping the source folder location and replacing with the output folder location.
PNG_IMAGES=$(addprefix $(IMAGE_OUTPUT_PATH)/,$(subst .uxf,.png,$(notdir $(UMLET_IMAGES))))



# Generic rule to convert a uxf file to an image file in the output path.
# Generic rule needs the path.
# NOTE: Calling the .exe will generate an image file, but it seems to be launched as an asyncronous process
#       Launching the java file seems to block until completion.
$(IMAGE_OUTPUT_PATH)/%.png: %.uxf
#	c:\tools\umlet\umlet -action=convert -format=png -filename=$< -output=$(@D)
#    PC-based umlet tool does not work that great - it seems to spawn asychronous threads for conversion which is an issue for makefile flow control.

#	C:\Program Files\Java\jre1.6.0_45\bin\java -jar c:\tools\umlet\umlet.jar -action=convert -format=png -filename=$< -output=$(@D)
# Assume java is in the system path.
	java -jar $(UMLET)\umlet.jar -action=convert -format=png -filename=$< -output=$@




umletConversion: $(PNG_IMAGES)






	
