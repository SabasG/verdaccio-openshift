# verdaccio-openshift

Setting up and running verdaccio as private npm registry for scoped packages in openshift.

## Set up

The following steps will create a verdaccio service exposed from openshift for handling private packages scoped as "@internal/".

All other npm packages will still be handled through npmjs registry. 

### Clone the repo

```sh
git clone https://github.com/SabasG/verdaccio-openshift.git && cd verdaccio-openshift
```

### Login to openshift

Login to your openshift cluster and select the project that will host verdaccio.

```sh
oc login ...
oc project ...
```

### Create config map

```sh
oc create -f verdaccio-ConfigMap.yaml
```

The config map holds the verdaccio [config file](https://verdaccio.org/docs/en/configuration) and the [htpasswd](https://github.com/verdaccio/monorepo/tree/master/plugins/htpasswd) file for the single verdaccio user.

### Create pvc

```sh
oc create -f verdaccio-PersistentVolumeClaim.yaml
```

### Create deployment config

```sh
oc create -f verdaccio-DeploymentConfig.yaml
```

### Create service

```sh
oc create -f verdaccio-Service.yaml
```

### Create route

```sh
oc create -f verdaccio-Route.yaml
```

### Configure npm

Execute the npm_config script.

We are using [npmrc](https://github.com/deoxxa/npmrc) in order to create a profile in which scoped packages are associated with the created registry.

```sh
bash ./npm_config.sh
```

### Login to verdaccio

Using web-ui through the created openshift route or through cli:

```sh
npm login --scope=@internal
```

Credentials:
- username: verdaccio
- password: verdaccio
