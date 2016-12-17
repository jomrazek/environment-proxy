package main

import (
  "bufio"
  "fmt"
  "log"
  "os"
  "strings"
  "text/template"
)

type Location struct {
  Match   string
  Service string
}

func main() {

  locations := []Location{}

  file, err := os.Open("/var/lib/haproxy/conf/custom_https.map")
  if err != nil {
    log.Fatal(err)
  }
  defer file.Close()

  scanner := bufio.NewScanner(file)
  for scanner.Scan() {
    data := strings.Fields(scanner.Text())
    location := Location{data[0], data[1]}
    locations = append(locations, location)
  }

  t := template.Must(template.ParseFiles(os.Getenv("TEMPLATE_FILE")))

  f, err := os.Create("/var/lib/haproxy/conf/haproxy.config")
  if err != nil {
    panic(err)
  }

  err = t.Execute(f, locations)

  if err != nil {
    fmt.Print(err)
    log.Fatal("Cannot write out config file")
  }
}
