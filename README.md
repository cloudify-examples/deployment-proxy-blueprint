# deployment-proxy-blueprint

This is an example blueprint for the Cloudify deployment proxy.

This feature is provided via the [cloudify-utilities-plugin](https://github.com/cloudify-incubator/cloudify-utilities-plugin/tree/v1.1.0).

## Explanation

The blueprint creates an AWS environment and brings up an ETCD cluster. Running the blueprint multiple times adds nodes to the cluster.

## Requirements

- AWS (EC2, VPC)
- cloudify-utilities-plugin v1.1.0

## Instructions

1. Edit the `environment_inputs` in `example-blueprint.yaml` to match your environment.

2. Execute the `example-blueprint.yaml`:

```shell
$ cfy install example-blueprint.yaml
```

The first stage of this installation deploys the AWS environment defined in `aws-environment.yaml`:

It uploads the blueprint and creates a deployment. Then executes the install workflow.

If the blueprint already exists or the deployment already exists, it will use the existing blueprint or deployment.

The install is designed for multiple installations, however this can be blocked via the plugin.

