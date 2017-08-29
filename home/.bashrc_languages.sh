# dlang workspace-d
export-path ~/codes/dlang/workspace-d/bin

# nim
if [[ `command -v nim` ]]; then
  nimcompile(){ nim c -d:release --hints:off --verbosity:0 $@ ; } # for compile
  alias nimr-pure="nimcompile -r" # pure
  nimr(){
    exename=`echo $1 | sed 's/\.[^\.]*$//'`
    [[ -f "nimcache/$exename" ]] && mv nimcache/$exename ./
    nimcompile -r -d:ssl $@
    [[ -f $exename ]] && [[ -d "nimcache" ]] && mv $exename nimcache
  }
  export-path ~/.nimble/bin/
  # oj
  nimoj(){
    if [[ "$1" == "" ]]; then
      echo "no nim file"
      return -1
    fi
    filename=$1
    file_id="${filename%.*}"
    file_id="${file_id:1}"
    nimcompile -o:a.out --overflowChecks:on $filename
    [[ $? != 0 ]] && return $?
    [[ ! -f test/$file_id  ]] && rm -r test
    [[ ! -d test ]] && oj dl "https://yukicoder.me/problems/no/$file_id"
    oj test
    touch test/$file_id
    rm a.out
  }
fi




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