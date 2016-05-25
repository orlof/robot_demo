class Selenium2LibraryStub:
    def __getattr__(self, name):
        return self.stub

    def stub(self, *args):
        pass
