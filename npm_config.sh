#!/bin/sh

# Set up of npmrc for managing profiles in order to access different registries.
# https://docs.npmjs.com/configuring-your-registry-settings-as-an-npm-enterprise-user

# Create a npmrc profile matching project scope.
profile="internal"
org="test.com"

# Prompt for email.
# read -p "Please enter your email: " emailAddress

# Install npmrc package.
npm i -g npmrc

# Create profile.
npmrc -c $profile

# Set general configuration properties.
npm config set email $profile@$org
npm config set strict-ssl false

# Associate scoped packages with the internal registry.
# https://docs.npmjs.com/using-npm/scope.html#associating-a-scope-with-a-registry
npm config set @$profile:registry https://verdaccio-jenkins.127.0.0.1.nip.io
