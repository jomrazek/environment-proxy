package main

import (
  "bufio"
  "log"
  "os"
  "strings"
  "text/template"
)

type Backend struct {
  Match   string
  Service string
}

func main() {

  log.SetOutput(os.Stderr)
  backends := []Backend{}

  file, err := os.Open("/var/lib/haproxy/conf/custom_https.map")
  if err != nil {
    log.Fatal(err)
  }
  defer file.Close()

  scanner := bufio.NewScanner(file)
  for scanner.Scan() {
    data := strings.Fields(scanner.Text())
    backend := Backend{data[0], data[1]}
    backends = append(backends, backend)
  }

  t := template.Must(template.ParseFiles(os.Getenv("TEMPLATE_FILE")))

  f, err := os.Create("/var/lib/haproxy/conf/haproxy.config")
  if err != nil {
    log.Fatal(err)
  }

  err = t.Execute(f, backends)

  if err != nil {
    log.Fatal(err)
  }
}
