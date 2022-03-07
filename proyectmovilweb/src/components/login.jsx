import React from "react";
//import css
import '../assets/css/login.css';
//import imagenes
import logo from '../assets/img/delivery-courier.png';
//SERVICIOS
import { Apiurl } from '../services/apirest';
//Librerias
import axios from 'axios';
//cookies




class login extends React.Component {

    // MANEJO DE ENRUTAMIENTO
    constructor(props) {
        super(props);
    }

    //AQUI SE CREAN LAS VARIABLES ESTATICAS QUE REQUIERE LA API
    state = {
        form: {
            "username": "",
            "password": "",
        },
        error: false,
        errorMsg: " NO puede ingresar al administrador.."
    }


    manejadorSubmit = e => {
        e.preventDefault();
    }


    manejadorChange = async e => {
        await this.setState({
            form: {
                ...this.state.form,
                [e.target.name]: e.target.value
            }
        })
    }


    manejadorBoton = async () => {
        let username = this.state.form.username
        let password = this.state.form.password

        let url = Apiurl + `/usuario/login/${username}/${password}`;
        await axios.get(url, this.state.form)
            .then(response => {
                console.log(response.data)
                if (response.data.msg === "1" && response.data.id_rol === 1) {
                    this.props.history.push("/dashboardAdmin")
                }else {
                    this.setState({
                        error: true,
                        errorMsg: response.data.msg
                    })
                }
            }).catch(error => {
                console.log(error);
                this.setState({
                    error: true,
                    errorMessage: "error al conectar a la api"
                })
            })
    }


    render() {
        return (
            <React.Fragment>
                <div className="bodylogin">
                    <div className="container wrapper">
                        <div className="row">
                            <div className="col-md-11 mt-60 mx-md-auto">
                                <div className="login-box bg-white pl-lg-5 pl-0">
                                    <div className="row no-gutters align-items-center">
                                        <div className="col-md-6">
                                            <div className="form-wrap bg-white">
                                                <form onSubmit={this.manejadorSubmit}>
                                                    <h4 align="center">Courier admin</h4>
                                                    <input type="text" id="username" className="fadeIn second" name="username" placeholder="Usuario" onChange={this.manejadorChange} />
                                                    <input type="password" id="password" className="fadeIn third" name="password" placeholder="Contraseña" onChange={this.manejadorChange} />
                                                    <input type="submit" className="fadeIn fourth" value="Iniciar Sesión" onClick={this.manejadorBoton} />
                                                </form>


                                                {/* control de error */}
                                                {this.state.error === true &&
                                                    <div className="alert alert-danger" role="alert">
                                                        {this.state.errorMsg}
                                                    </div>
                                                }


                                            </div>
                                        </div>
                                        <div className="col-md-6">
                                            <div className="content text-center">
                                                <div className="border-bottom pb-5 mb-2">
                                                    <img src={logo} alt="" />
                                                </div>
                                                <small>@Desarrolado por Alan xd</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </React.Fragment>
        );
    }
}

export default login