{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "affiliates.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "affiliates.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "affiliates.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper Affiliates DB image name
*/}}
{{- define "affiliates.db" -}}
{{- $registryName := .Values.db.registry -}}
{{- $repositoryName := .Values.db.repository -}}
{{- $tag := .Values.db.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf "%s/%s:%s" .Values.global.imageRegistry $repositoryName $tag -}}
    {{- else -}}
        {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Affiliates WEB image name
*/}}
{{- define "affiliates.web" -}}
{{- $registryName := .Values.web.registry -}}
{{- $repositoryName := .Values.web.repository -}}
{{- $tag := .Values.web.tag | toString -}}
{{- printf "%s/%s:%s" $registryName .Values.web.repository $tag -}}
{{- end -}}

{{/*
Return the proper Affiliates API image name
*/}}
{{- define "affiliates.api" -}}
{{- $registryName := .Values.api.registry -}}
{{- $repositoryName := .Values.api.repository -}}
{{- $tag := .Values.api.tag | toString -}}
{{- printf "%s/%s:%s" $registryName .Values.api.repository $tag -}}
{{- end -}}

{{/*
Return the proper Affiliates rabbitmq image name
*/}}
{{- define "affiliates.rabbitmq" -}}
{{- $registryName := .Values.rabbitmq.registry -}}
{{- $repositoryName := .Values.rabbitmq.repository -}}
{{- $tag := .Values.rabbitmq.tag | toString -}}
{{- printf "%s/%s:%s" $registryName .Values.rabbitmq.repository $tag -}}
{{- end -}}
