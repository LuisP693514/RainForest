import React from 'react';
import { Route, Switch } from 'react-router-dom';
import LoginFormPage from './components/LoginFormPage';
import Navigation from './components/Navigation';
import PageNotFound from './components/PageNotFound';
import SignUpFormPage from './components/SignUpFormPage';

function App() {
  return (
    <Switch>
      <Route path="/login" component={LoginFormPage}/>
      <Route path='/signup' component={SignUpFormPage}/>
      <Route path='/' exact component={Navigation}/>
      <Route path="*" component={PageNotFound}/>
    </Switch>
  );
}

export default App;
