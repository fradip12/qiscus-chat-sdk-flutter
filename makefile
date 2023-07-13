
pods-clean:
	rm -Rf ios/Pods ; \
	rm -Rf ios/.symlinks ; \
	rm -Rf ios/Flutter/Flutter.framework ; \
	rm -Rf ios/Flutter/Flutter.podspec ; \
	rm ios/Podfile.lock ; \

clean:
	echo "Cleaning the project" ; \
	fvm flutter clean ; \

get:
	echo "Updating dependencies" ; \
	fvm flutter pub get ; \
