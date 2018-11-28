from validators import (
    validate_dns_dashboard,
    validate_storage,
    validate_ingress,
    validate_istio,
    validate_registry,
    validate_forward,
    validate_metrics_server,
    validate_fluentd,
)
from utils import wait_for_pod_state


class TestLiveAddons(object):
    """
    Validates a microk8s with all the addons enabled
    """

    def _test_dns_dashboard(self):
        """
        Validates dns and dashboards work.

        """
        wait_for_pod_state("", "kube-system", "running", label="k8s-app=kube-dns")
        validate_dns_dashboard()

    def _test_storage(self):
        """
        Validates storage works.

        """
        validate_storage()

    def _test_ingress(self):
        """
        Validates ingress works.

        """
        validate_ingress()

    def _test_istio(self):
        """
        Validate Istio works.

        """
        validate_istio()

    def _test_registry(self):
        """
        Validates the registry works.

        """
        validate_registry()

    def _test_forward(self):
        """
        Validates port forward works.

        """
        validate_forward()

    def _test_metrics_server(self):
        """
        Validates metrics server works.

        """
        validate_metrics_server()

    def test_fluentd(self):
        """
        Validates fluentd.

        """
        validate_fluentd()
