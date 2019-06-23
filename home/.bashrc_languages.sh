# nim
if [[ -x "$(command -v nim)" ]]; then
  nimcompile(){
    nim c --hints:off --verbosity:0 --nimcache:./nimcache "--warning[SmallLshouldNotBeUsed]:off" $@ ;
  } # for compile
  alias nimr-pure="nimcompile -r" # pure
  nimr(){
    # $@[-1]
    exename="$(echo $1 | sed 's/\.[^\.]*$//')"
    [[ -f "nimcache/$exename" ]] && mv nimcache/$exename ./
    nimcompile $NIMR_COMPILE_FLAG -r $@
    [[ -f $exename ]] && [[ -d "nimcache" ]] && mv $exename nimcache
  }
  nimrr(){
    NIMR_COMPILE_FLAG="-d:release" nimr $@
  }
fi
if [[ -x "$(command -v go)" ]]; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

# crystal
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig
