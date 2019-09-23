#!/usr/bin/env bash

fg="$(get_xres color15)"
fg_light="$(get_xres color8)"

echo -ne "%{F$fg} $(date +%H%M) %{F$fg_light}hrs %{F$fg} $(date +%d/%m) %{F$fg_light} $(date +%Y)"
