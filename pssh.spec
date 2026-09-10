%global pypi_name pssh

Name:           pssh
Version:        2.3.6
Release:        1%{?dist}
Summary:        Parallel SSH tools

License:        BSD
URL:            https://github.com/lilydjwg/pssh
Source0:        %{pypi_name}-%{version}.tar.gz

BuildArch:      noarch

BuildRequires:  python3-devel
BuildRequires:  python3-setuptools
Requires:       openssh-clients
Requires:       python3 >= 3.5

%description
PSSH (Parallel SSH) provides parallel versions of OpenSSH and related tools,
including pssh, pscp, prsync, pnuke, and pslurp. The project includes psshlib
which can be used within custom applications.

%prep
%autosetup -n %{pypi_name}-%{version}

%build
%py3_build

%install
%py3_install

%files
%license COPYING
%doc README.md
%{python3_sitelib}/psshlib/
%{_bindir}/pssh
%{_bindir}/pscp
%{_bindir}/prsync
%{_bindir}/pnuke
%{_bindir}/pslurp
%{_bindir}/pssh-askpass

%changelog
* Thu Sep 10 2026 Your Name <your.email@example.com> - 2.3.5-1
- Initial package for pssh
- Parallel SSH tools suite
