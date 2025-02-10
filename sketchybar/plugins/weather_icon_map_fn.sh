function icon_map() {
  case "$1" in
  "113")
    if [ "$2" = "night" ]; then
      icon_result="􀆹"
    else
      icon_result="􀆭"
    fi
    ;;
  "116" | "119")
    if [ "$2" = "night" ]; then
      icon_result="􀇚"
    else
      icon_result="􀇔"
    fi
    ;;
  "122")
    icon_result="􀇂"
    ;;
  "392")
    icon_result="􀇎"
    ;;
  "143" | "248" | "260")
    icon_result="􀇊"
    ;;
  "176" | "293" | "296" | "266" | "263" | "353" | "356")
    icon_result="􀇄"
    ;;
  "299" | "302" | "305" | "308" | "359")
    icon_result="􀇈"
    ;;
  "200" | "386" )
    icon_result="􀇞"
    ;;
  "389")
    icon_result="􀇞"
    ;;
  "179" | "182" | "185" | "281" | "284" | "311" | "314" | "317" | "350" | "362" | "365" | "374" | "377")
    icon_result="􀇐"
    ;;
  "227" | "320" | "323" | "326" | "368")
    icon_result="􁷐"
    ;;
  "230" | "329" | "332" | "335" | "338" | "371" | "395")
    icon_result="􀇎"
    ;;
  "392")
    icon_result="􀇏"
    ;;
  *)
    if [ "$2" = "night" ]; then
      icon_result="􀆹"
    else
      icon_result="􀆭"
    fi
    ;;
  esac
}

icon_map $1 $2

echo $icon_result
