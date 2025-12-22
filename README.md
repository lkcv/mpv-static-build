# mpv-static-build
## Collection of scripts to produce a mostly static build of mpv (only libc and libm are dynamically linked)<br/><br/>Inspired by the mpv-build project, so parts of some of the build scripts like ffmpeg are the same

## Tested on:
* Arch
* Ubuntu 22.04 (in progress)

## Caveats:
The builds produced by these scripts are wayland-only and without VAAPI or VDPAU support.
All X11 and EGL features have been disabled to make this feasible. Hardware acceleration works through vulkan video, so I don't think we're missing out on much here.

This project also does stupid things (because we can) like statically link libpipewire and libvulkan. It probably won't hurt anything and gets the ldd count down for the binary.
<br/>
<br/>
## Features:
* Vulkan with hardware accel decode via vulkan video (hevc and av1 work. vp9 should, but it's untested)
* Wayland (waylandvk)
* DRM (displayvk)
* Pipewire
* And most optional features are available. Check build.sh for a list of all build checks. Some features have been skipped by default. Refer to **Usage** below to enable them.

## Usage:
Just run **./build.sh**

The main script (build.sh) propagates environment variables to the check and build scripts for each repo.
When no environment variables are specified, each repo will only rebuild after successfully pulling changes via git pull. This assumes they're on a branch.
The binary will be in repos/mpv/build after it's built.
<br/>
<br/>
### SKIP="anything"
Will skip the rest of the repo check. Shouldn't be used for necessary repos if they haven't been built yet since that will cause the build to fail at a later stage.
Any value can be specified after SKIP to make it work.
<br/>
<br/>
### CLEAN_BUILD="yes" 
This will delete the build_libs directory in the root of the repo and along with the repos folder which contains all downloaded repos.
It can also be specified in build.sh in front of individual repos, but this way is functionally identical to **REBUILD="whatever repo"**.
<br/>
<br/>
### TAG="some tag"
This will switch the specified repo to that tag and should be used only in build.sh
Both tags and branches, such as main or master can be specified.

On subsequent rebuilds, if the tag of the repo hasn't changed (whether TAG is still specified or not), that repo will not be rebuilt because there's nothing to update.
The exception to this is **REBUILD**

If the current tag is a branch, git pull will be executed. This is true whether TAG is specified or not.
<br/>
<br/>
### REBUILD="whatever repo"
Can be specified in front of the script but only for 1 repo if done this way. It's better to prepend this in front of the individual check scripts in build.sh
If specified without **TAG="some tag"**, whether that TAG is an actual branch or not, git pull won't be executed, so it'll just rebuild the repo as-is.
<br/>
<br/>
### Example in build.sh

```
scripts/fontconfig-check
SKIP="yes" scripts/libjpeg-check 
TAG="v1.4.335" scripts/vulkan-headers-check 
TAG="v1.4.335" scripts/vulkan-loader-check 
REBUILD="SPIRV-Tools" scripts/spirv-tools-check
```

### TODO
Figure out if musl can build all of these reliably
