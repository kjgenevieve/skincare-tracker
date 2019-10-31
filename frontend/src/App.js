import React from "react";
import { BrowserRouter as Router } from 'react-router-dom'
import "./App.css";
import NavBar from "./components/NavBar";
import Header from "./components/Header";
import Main from "./containers/Main";

function App() {
  return (
    <div>
      <Router>
        <NavBar />
        <Header />
        <Main />
      </Router>
    </div>
  );
}

export default App;
