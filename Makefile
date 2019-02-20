.SHELLFLAGS = -c -e
# PLATFORMS = linux/armv6 doesn't work? 🤦
# https://github.com/elastic/beats/blob/master/dev-tools/mage/platforms.go#L327
export PLATFORMS = +all linux/armv6

.PHONY: all
all: $(GOPATH)/src/github.com/elastic/beats
	$(MAKE) --directory $(GOPATH)/src/github.com/elastic/beats release

$(GOPATH)/src/github.com/elastic/beats: #$(GOPATH)/src/github.com/elastic
	git clone \
	  --branch $$(curl https://api.github.com/repos/elastic/beats/releases/latest | jq --raw-output .tag_name) \
	  --depth 1 \
	  https://github.com/elastic/beats.git $@

$(GOPATH)/src/github.com/elastic:
	mkdir --parents $@
