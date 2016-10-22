export PIP_REQUIRE_VIRTUALENV=true

gpip(){
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}