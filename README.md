# Cloud repository scripts

All the scripts are meant to be executed through the OpenBaton EMS component, so some of them require some environment variables to be available.

### start-single-mongo.sh

One of the most important script is __start-single-mongo.sh__ and it is in charge of starting and configuring a single VM MongoDB instance.
There are *no Mandatory Environment Variables*.

|Env Var Name   | description                                   | default value   |
|---------------|-----------------------------------------------|-----------------|
|PORT           | MongoDB listening to incoming connection port |27018            |
|SECURITY       | Activate security                             |false            |
|SMALLFILES     | Let start mongo with --smallfile argument     |false            |

__NOTE__: If SECURTITY is set to true then two other Environment Variables are mandatory:

|Env Var Name   | description                                   |
|---------------|-----------------------------------------------|
|USERNAME_MD    | Username to use to connect to MongoDB         |
|PASSWORD       | Password associated to the username selected  |