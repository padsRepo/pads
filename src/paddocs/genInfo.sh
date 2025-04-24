#!/bin/bash

printf \
"
---
title: $title $subtitle
section: 1
version: $version
header: Comprehensive Documentation
footer: $title $version
date: $created
toc: true
navOrder: forward, updates, command line, tutorials, reference
---

$brief

$copyright

"
