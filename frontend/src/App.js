import React from 'react';
import { Route, Switch } from 'react-router-dom';
import LoginFormPage from './components/LoginFormPage';
import PageNotFound from './components/PageNotFound';
import SignUpFormPage from './components/SignUpFormPage';
import ProductShowPage from './components/ProductShowPage';
import HomePage from './components/HomePage';
import CategoryShowPage from './components/CategoryShowPage';
import CartShowPage from './components/CartShowPage';
import CartCheckOutPage from './components/CartCheckOutPage';

function App() {
  return (
    <Switch>
      <Route path='/categories/:categoryId' component={CategoryShowPage}/>
      <Route path='/products/:productId' component={ProductShowPage}/>
      <Route path='/checkout' component={CartCheckOutPage}/>
      <Route path='/signup' component={SignUpFormPage}/>
      <Route path="/login" component={LoginFormPage}/>
      <Route path='/cart' component={CartShowPage}/>
      <Route path='/' exact component={HomePage}/>
      <Route path="*" component={PageNotFound}/>
    </Switch>
  );
}

export default App;
