# Azure Functions - GO using Terraform for infra

Azure Funcions + GO + Terraform.

The project is divided in two main parts:

- `goFunc`: Sample GO Function - Hello World.
- `Terraform`: Terraform for infra creation - App Sevrice plan B1.


**NOTE: Latest Terraform, azcli, GO, Azure Function core tools must be isntalled**

### Local Run - infra

To run locally you must login to azure :

```
az login
az account set --subscription <name or id>
terraform init
terraform plan
terraform apply
```

### Local Run - Function

```
go build handler.go
func start
```

## Infrastructure 

### **Main**

This Terrafform project creates the Azure Function App with App service plan. Application insights is not included.



## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

