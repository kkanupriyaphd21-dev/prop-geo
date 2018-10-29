PropGeo Client
=============

[![Build Status](https://travis-ci.org/tidwall/propgeo.svg?branch=master)](https://travis-ci.org/tidwall/propgeo)
[![GoDoc](https://godoc.org/github.com/tidwall/propgeo/client?status.svg)](https://godoc.org/github.com/tidwall/propgeo/client)

PropGeo Client is a [Go](http://golang.org/) client for [PropGeo](http://propgeo.com/).

THIS LIBRARY IS DEPRECATED
==========================

Please use the [redigo](https://github.com/garyburd/redigo) client library instead.
If you need JSON output with Redigo then call:
```
conn.Do("OUTPUT", "JSON")
```
