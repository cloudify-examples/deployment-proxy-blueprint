# deployment-proxy-blueprint

The purpose of this example is to showcase in a simple, but meaningful manner, the [Cloudify Deployment Proxy](https://github.com/cloudify-incubator/cloudify-utilities-plugin/tree/v1.1.1/cloudify_deployment_proxy).

The deployment proxy enables one Cloudify deployment to reference another deployment.


## Requirements

- AWS (EC2, VPC)
- cloudify-utilities-plugin v1.1.0


## Example

This blueprint creates a simple etcd cluster.

It has two stages:

1. Creation of the cluster service discovery, as well as deployment of an AWS VPC, subnet, and security group.
2. Creation of NICs, VMs, and the etcd nodes themselves.

The first stage is performed once. The second stage can be performed multiple times to reach the desired number of cluster members.

_The nice thing about the deployment proxy is that a single blueprint contains both stages and can be run multiple times. The plugin will identify that the first stage has already been executed, and will treat it as an external resource._


## Instructions

1. Edit the `environment_inputs` in `example-blueprint.yaml` to match your environment.

2. Execute the `example-blueprint.yaml`:

```shell
$ cfy install example-blueprint.yaml
```

2b. Or to see execute the blueprint multiple times, try something like this:

```shell
$ for i in {1..3}
> do
> cfy install example-blueprint.yaml -b test$i
> done
```

3. Now install again, or just uninstall:

```shell
$ cfy uninstall example-blueprint --allow-custom-parameters -p ignore_failure=true
```

3b. If you ran the loop, run this:

```shell
$ for i in {3..1}
> do
> cfy uninstall test$i --allow-custom-parameters -p ignore_failure=true
> done
```


## Explanation

The first stage, which governs the initialization of the cluster and the environment uses the main blueprint file ```aws-environment.yaml```, which imports ```imports/resources/etcd-discovery-service.yaml```.

These blueprints define outputs, for example the cluster discovery URL is defined like this:

```yaml

node_templates:

  etcd_discovery_service:
    type: cloudify.nodes.Root
    interfaces:
      cloudify.interfaces.lifecycle:
        configure:
          implementation: imports/resources/scripts/etcd/configure.sh
          executor: central_deployment_agent

outputs:

  discovery_url:
    value: { get_attribute:  [ etcd_discovery_service, DISCOVERY_URL ] }

```

When the first blueprint ```aws-environment.yaml``` is uploaded, deployed, and installed, these values are stored as outputs available from the Cloudify API.

These outputs are consumed by the deployment proxy, which is defined like this:

```yaml

node_templates:

  environment:
    type: cloudify.nodes.DeploymentProxy
    properties:
      resource_config:
        blueprint:
          id: { get_input: environment_name }
          blueprint_archive: { get_input: environment_blueprint }
          main_file_name: { get_input: environment_blueprint_filename }
        deployment:
          id: { get_input: environment_name }
          inputs: { get_input: environment_inputs }
          outputs:
            public_subnet_id: public_subnet_id
            private_subnet_id: private_subnet_id
            group_id: group_id
            key_path: key_path
            key_name: key_name
            availability_zone: availability_zone
            region_name: region_name
            region_endpoint: region_endpoint
            discovery_url: DISCOVERY_URL

```

The deployments dictionary defines the outputs and which values to map them to in the deployment proxy node's runtime properties.

The deployment proxy is in ```example-blueprint.yaml```.

To manage the entire deployment of both stages, only this blueprint needs to be executed. (Although, stage 1 and 2 can be executed separately. The only necessary step is to verify that the resource_config:deployment:id is accurate in the deployment proxy node properties.)


* Acknowledgement: The etcd service discovery model is based on the [public service discovery service](https://coreos.com/etcd/docs/latest/op-guide/clustering.html#etcd-discovery). *

