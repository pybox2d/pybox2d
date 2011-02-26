"""
"""
import widget

class Form(widget.Widget):
    """A form that automatically will contain all named widgets.
    
    <p>After a form is created, all named widget that are subsequently created are added
    to that form.  You may use dict style access to access named widgets.</p>
    
    <pre>Form()</pre>
    
    <strong>Example</strong>
    <code>
    f = gui.Form()
    
    w = gui.Input("Phil",name="firstname")
    w = gui.Input("Hassey",name="lastname")
    
    print f.results()
    print ''
    print f.items()
    print ''
    print f['firstname'].value
    print f['lastname'].value
    </code>
    """

    # The current form instance
    form = None
    
    def __init__(self):
        widget.Widget.__init__(self,decorate=False)
        self._elist = []
        self._emap = {}
        self._dirty = 0
        Form.form = self
    
    def add(self,e,name=None,value=None):
        if name != None: e.name = name
        if value != None: e.value = value
        self._elist.append(e)
        self._dirty = 1
    
    def _clean(self):
        for e in self._elist[:]:
            if not hasattr(e,'name') or e.name == None:
                self._elist.remove(e)
        self._emap = {}
        for e in self._elist:
            self._emap[e.name] = e
        self._dirty = 0
    
    def __getitem__(self,k):
        if self._dirty: self._clean()
        return self._emap[k]
    
    def __contains__(self,k):
        if self._dirty: self._clean()
        if k in self._emap: return True
        return False
    
    def results(self):
        """Return a dict of name => values.
        
        <pre>Form.results(): return dict</pre>
        """
        if self._dirty: self._clean()
        r = {}
        for e in self._elist:
            r[e.name] = e.value
        return r
    
    def items(self):
        """Return a list of name, value keys.
        
        <pre>Form.items(): return list</pre>
        """
        return self.results().items()
    
    #def start(self):
    #    Object.start(self,-1)
