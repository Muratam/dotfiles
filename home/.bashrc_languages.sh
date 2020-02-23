# nim
if [[ -x "$(command -v nim)" ]]; then
  nimcompile(){
    nim cpp --hints:off --verbosity:0 \
      "--warning[SmallLshouldNotBeUsed]:off" \
      $@ ;
      # "--warning[UnusedImport]:off" \
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
  nimrepl(){
    choosenim 0.19.2 > /dev/null
    rlwrap replim $@  # | sed -e '1,5d'
  }
fi
# type script
if [[ -x "$(command -v tsc)" ]]; then
  tscr(){
    exename="$(echo $1 | sed 's/\.[^\.]*$//')".js
    tsc $1
    [[ -f $exename ]] && node $exename ${@[@]:2}
    [[ -f $exename ]] && rm $exename
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
