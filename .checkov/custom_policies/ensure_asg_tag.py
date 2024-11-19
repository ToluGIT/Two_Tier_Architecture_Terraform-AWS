from checkov.common.models.enums import CheckResult, CheckCategories
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck

class EnsureASGTag(BaseResourceCheck):
    def __init__(self):
        name = "Ensure resources have a tag named 'asg'"
        id = "CUSTOM_AWS_001"
        supported_resources = ["aws_*"]  # Apply to all AWS resources (modify as needed for specific types)
        categories = [CheckCategories.GENERAL_SECURITY]
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources)

    def scan_resource_conf(self, conf):
        """
        Check if 'tags' attribute contains the 'asg' tag.
        """
        if "tags" in conf:
            tags = conf.get("tags")[0]
            if isinstance(tags, dict) and "asg" in tags:
                return CheckResult.PASSED
        return CheckResult.FAILED

scanner = EnsureASGTag()
