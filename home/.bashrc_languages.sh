# dlang workspace-d
export-path ~/codes/dlang/workspace-d/bin

# nim
if [[ -x "$(command -v nim)" ]]; then
  nimcompile(){ nim c -d:release --hints:off --verbosity:0 $@ ; } # for compile
  alias nimr="nimcompile -r" # run
  alias nimr++="nimcompile -r -d:ssl" # all in one
fi

# for yukicoder :: DOWNLOAD No.$(basename $(pwd)) && TEST a.out
yukioj(){
  if [[ ! -d test ]]; then
    if [[ "$1" == "" ]]; then # no problem number
      oj dl "https://yukicoder.me/problems/no/$(basename $(pwd))"
    else
      oj dl "https://yukicoder.me/problems/no/$1"
    fi
  fi
  oj test
}
# /**/5 , *.nim => test yukicoder
nimoj(){
  if [[ "$1" == "" ]]; then # no filename
    nimcompile -o:a.out *.nim
  elif [[ "$1" == "clean" ]]; then
    rm -rf test a.out nimcache
    return 0
  else
    nimcompile -o:a.out $@
  fi
  echo "[[ a.out ]]"
  yukioj
}

# nvm
if [[ -d "${HOME}/.nvm" ]]; then
  export NVM_DIR="${HOME}/.nvm"
  [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh" > /dev/null
  nvm use stable > /dev/null
fi

# rust (@.cargo | .rustup)
if [[ -d ~/.cargo ]] && [[ -d ~/.rustup ]] ; then
  export-path ~/.cargo/bin
  alias rs='cargo run --quiet --bin' # for test
  rsx(){ cd ~/.rustup/sandbox/ ; cargo build --release --quiet ; $@ ; cd - > /dev/null; }
  export-path ~/.rustup/sandbox/target/release
  if [[ "$(uname)" == 'Darwin' ]]; then
    export RUST_SRC_PATH=~/.multirust/toolchains/beta-x86_64-apple-darwin/lib/rustlib/src/rust/src
  fi
fi



if [[ "$(hostname)" == "ringo" ]]; then
  #python naoqi
  export PYTHONPATH=${PYTHONPATH}:~/python/pepper/naoqi
  export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:~/python/pepper/naoqi
  unset MAILCHECK
fi