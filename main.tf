terraform {
	required_providers {
		github = {
			source = "integrations/github"
			version = "~>5.0"
		}
	}
}

# Read token from the token.txt file
provider "github" {
	token = file("token.txt")
}

resource "github_repository" "terraform_example" {
	name = "terraform_example"
	description = "My awesome repository created with terraform"
	visibility = "public"	
	auto_init = true
}	

resource "github_branch" "production" {
	repository = github_repository.terraform_example.name
	branch = "production"
}

resource "github_branch" "development" {
	repository = github_repository.terraform_example.name
	branch = "development"
}

resource "github_branch" "test"{
	repository = github_repository.terraform_example.name
	branch = "test"
}

#Update this file to the repository
resource "github_repository_file" "main_tf" {
  repository          = github_repository.terraform_example.name
  branch              = "main"
  file                = "main.tf"  
	content 					  = file("main.tf")
  overwrite_on_create = true
}