{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "redash.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "redash.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "redash.databaseurl" -}}
{{- if .Values.db.containerEnabled -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "postgresql://%s:%s@%s-%s-%s:%s/%s" .Values.db.meta.user .Values.db.meta.pass .Release.Name $name .Values.db.service.name .Values.db.meta.port .Values.db.meta.name | b64enc | quote -}}
{{- else -}}
{{- printf "postgresql://%s:%s@%s:%s/%s" .Values.db.meta.user .Values.db.meta.pass .Values.db.meta.host .Values.db.meta.port .Values.db.meta.name | b64enc | quote -}}
{{- end -}}
{{- end -}}
