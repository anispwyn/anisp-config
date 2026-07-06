{
  chatterino7,
  fetchFromCodeberg,
}:
chatterino7.overrideAttrs (oldAttrs: {
  pname = "moltorino";
  src = fetchFromCodeberg {
    owner = "MoltoBenne";
    repo = "Moltorino";
    rev = "911a2b4372";
    hash = "sha256-noYsdz8lVn3jKrbT6fhw9zCya4rRimyTCQ9gL+0KBQo=";
    fetchSubmodules = true;
  };
  postPatch =
    (oldAttrs.postPatch or "")
    + ''
      substituteInPlace src/providers/moltorino/MoltorinoPresence.cpp \
        --replace "this->transmitPresenceConnection_ =" "" \
        --replace "this->activityHeartbeatConnection_ =" "" \
        --replace "this->heartbeatAccountConnection_ =" ""
    '';
  env =
    (oldAttrs.env or {})
    // {
      QT_NO_PRIVATE_MODULE_WARNING = "ON";
    };
})
