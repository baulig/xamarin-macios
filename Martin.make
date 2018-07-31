ROOT = /Developer/Work/xamarin-macios
MONO_ROOT = $(ROOT)/external/mono
COREFX_ROOT = $(MONO_ROOT)/external/corefx
SIM64_BUILD_ROOT = $(MONO_ROOT)/sdks/builds/ios-sim64-release
SIM64_BUILD_OUT = $(MONO_ROOT)/sdks/out/ios-sim64-release

NATIVE_APPLE_DIR = $(COREFX_ROOT)/src/Native/Unix/System.Security.Cryptography.Native.Apple

IOS_BUILD = $(ROOT)/_ios-build/Library/Frameworks/Xamarin.iOS.framework/Versions/git

all::
	@echo $(ROOT)

dir-native-apple::
	@echo $(NATIVE_APPLE_DIR)

corlib-monotouch::
	$(MAKE) -C $(MONO_ROOT)/mcs/class/corlib PROFILE=monotouch all install
	cp $(MONO_ROOT)/mcs/class/lib/monotouch/mscorlib.dll $(IOS_BUILD)/lib/mono/Xamarin.iOS/

system-monotouch::
	$(MAKE) -C $(MONO_ROOT)/mcs/class/System PROFILE=monotouch all install
	cp $(MONO_ROOT)/mcs/class/lib/monotouch/System.dll $(IOS_BUILD)/lib/mono/Xamarin.iOS/

sim64-runtime::
	$(MAKE) -C $(SIM64_BUILD_ROOT)/mono all install
	cp $(SIM64_BUILD_OUT)/lib/libmono-apple-crypto.* $(IOS_BUILD)/SDKs/MonoTouch.iphonesimulator.sdk/usr/lib/
	cp $(SIM64_BUILD_OUT)/lib/libmonosgen-* $(IOS_BUILD)/SDKs/MonoTouch.iphonesimulator.sdk/usr/lib/

nm-crypto::
	nm $(SIM64_BUILD_ROOT)/mono/metadata/.libs/libmono-apple-crypto.dylib
