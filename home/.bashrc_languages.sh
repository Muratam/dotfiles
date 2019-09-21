# nim
if [[ -x "$(command -v nim)" ]]; then
  nimcompile(){
    nim cpp --hints:off --verbosity:0 \
      "--warning[SmallLshouldNotBeUsed]:off" $@ ;
  } # for compile
  alias nimr-pure="nimcompile -r" # pure
  nimr(){
    # $@[-1]
    exename="$(echo $1 | sed 's/\.[^\.]*$//')"
    # [[ -f "nimcache/$exename" ]] && mv nimcache/$exename ./
    nimcompile $NIMR_COMPILE_FLAG -r $@
    [[ -f $exename ]] && rm $exename
    # [[ -f $exename ]] && [[ -d "nimcache" ]] && mv $exename nimcache
  }
  nimrr(){
    NIMR_COMPILE_FLAG="-d:release" nimr $@
  }
fi
# type script
if [[ -x "$(command -v tsc)" ]]; then
  tscr(){
    tsc $1 --outFile a.out.js
    [[ -f a.out.js ]] && node a.out.js ${@[@]:2}
    [[ -f a.out.js ]] && rm a.out.js
  }
fi
# go
if [[ -x "$(command -v go)" ]]; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

# crystal
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig

source ~/.gvm/scripts/gvm
