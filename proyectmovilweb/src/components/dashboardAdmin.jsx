import "bootstrap/dist/css/bootstrap.min.css";
import '../assets/css/App.css';
import React, { Component } from 'react';
import Row from 'react-bootstrap/Row'
import Col from 'react-bootstrap/Col'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSearch } from '@fortawesome/free-solid-svg-icons';
import Card from 'react-bootstrap/Card'
import axios from 'axios';
import swal from 'sweetalert';
import ListGroup from 'react-bootstrap/ListGroup'
import ListGroupItem from 'react-bootstrap/ListGroupItem'
import { Button } from 'react-bootstrap';
import Navbar from '../assets/nav/navAdmin';
import logo from '../assets/img/delivery-courier.png';
const url = "http://localhost:3000/proceso/webmaster";
const urlPutpedido = "http://localhost:3000/pedidos/update/";
class dashboardAdmin extends Component {
    state = {
        posts: [],
        tablaUsuarios: [],
        busqueda: "",
        form: {
            estado: 'S',
        },
        form2: {
            estado: 'E',
        },
    };
    peticionGet = () => {
        axios.get(url).then(response => {
            this.setState({
                posts: response.data,
                tablaUsuarios: response.data
            });
            console.log(response.data);
        });
    }

    peticionPut = (idpedidos) => {
        console.log(idpedidos);
        console.log(this.state.form);
        axios.put(urlPutpedido + idpedidos, this.state.form).then(response => {
            this.peticionGet();
        })
    }
    peticionPutenviar = (idpedidos) => {
        console.log(idpedidos);
        console.log(this.state.form);
        axios.put(urlPutpedido + idpedidos, this.state.form2).then(response => {
            this.peticionGet();
        })
    }
    filter(event) {
        console.log(event.target.value)
        var text = event.target.value
        const data = this.state.tablaUsuarios;
        const newData = data.filter(function (item) {

            const idpedido = item.idpedidos.toString().toUpperCase()
            const estado = item.estado.toString().toUpperCase()
            const nombre = item.persona.nombres.toString().toUpperCase()
            const dni = item.persona.dni.toString().toUpperCase()
            const campo = nombre + ' ' + idpedido + ' ' + estado + dni
            const textData = text.toUpperCase()
            return campo.indexOf(textData) > -1
        })
        this.setState({
            posts: newData,
            busqueda: text,
        })
    }
    componentDidMount() {
        this.peticionGet()
    }

    render() {
        const alertaConfirmacion = (pedido) => {
            swal({
                title: "Envio de pedido",
                text: "Estás seguro que deseas enviar el pedido?",
                icon: "warning",
                buttons: ["No", "Si"]
            }).then(repuesta => {
                if (repuesta) {
                    swal({
                        text: "El pedido se a enviado con exito",
                        icon: "success"
                    });
                    this.peticionPut(pedido)
                    console.log(pedido);
                }
            })
        }
        const alertaenviar = (pedido) => {
            swal({
                title: "Confirmacion de pedido",
                text: "Estás seguro que deseas confirmar pedido?",
                icon: "warning",
                buttons: ["No", "Si"]
            }).then(repuesta => {
                if (repuesta) {
                    swal({
                        text: "El pedido se a confirmado con exito",
                        icon: "success"
                    });
                    this.peticionPutenviar(pedido)
                    console.log(pedido);
                }
            })
        }
        return (
            <>
                <Navbar />
                <br /><br /><br /><br /><br /><br />
                <div>
                    <div className="containerInput" >
                        <input className="form-control" placeholder="Búsqueda por id / Nombre / dni / estado"
                            value={this.state.busqueda} onChange={(text) => this.filter(text)} />

                        <button className="btn btn-success">
                            <FontAwesomeIcon icon={faSearch} />
                        </button>
                    </div>
                    <Row xs={1} md={4} className="g-4" >
                        {this.state.posts.map(pedido => {
                            return (
                                <Col md={4} className="mb-2" key={pedido.idpedidos}>
                                    <Card className="carta" style={{ backgroundColor: pedido.estado === 'A' ? '#ABEBC6' : pedido.estado === 'E' ? '#F0B27A' : '#F1948A' }} >
                                        <Card.Body >
                                            <Card.Title className="row justify-content-center" >{pedido.idpedidos}</Card.Title>

                                        </Card.Body>
                                        <ListGroup className="list-group-flush">
                                            <ListGroupItem>
                                                <img className="photo" src={logo} />
                                            </ListGroupItem>
                                            <ListGroupItem align="center">
                                                <a href={logo} download={logo}>
                                                    <button type="button">Descargar</button>
                                                </a>
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                Nombre: {
                                                    pedido.persona.nombres
                                                }
                                            </ListGroupItem>

                                            <ListGroupItem>
                                                telefono: {
                                                    pedido.persona.telefono
                                                }
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                Correo: {
                                                    pedido.persona.correo
                                                }
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                DNI: {
                                                    pedido.persona.dni
                                                }
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                shipper: {
                                                    pedido.shipper
                                                }
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                consignee: {
                                                    pedido.consignee
                                                }
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                Carrier: {
                                                    pedido.carrier
                                                }
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                Tracking: {
                                                    pedido.tracking
                                                }
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                Valor compra: {
                                                    new Intl.NumberFormat("en-EN").format(pedido.valorcompra)
                                                }
                                            </ListGroupItem>
                                            <ListGroupItem>
                                                Detalle compra: {
                                                    pedido.detallecompra
                                                }
                                            </ListGroupItem>
                                        </ListGroup>

                                        <Card.Footer>
                                            <ListGroupItem>
                                                <p style={{ fontSize: "22px", textAlign: "center", color: "black" }}>{pedido.estado === 'A' ? 'Activo' : pedido.estado === 'S' ? 'Enviado' : 'Confirmar eliminacion del user'}</p>
                                            </ListGroupItem>
                                        </Card.Footer>
                                        {pedido.estado === 'A' ?
                                            <>
                                                <Button style={{ backgroundColor: '#1E8449' }} onClick={() => alertaConfirmacion(pedido.idpedidos)} variant="primary" type="submit">Enviar</Button>&nbsp;&nbsp;&nbsp;&nbsp;
                                            </>
                                            : pedido.estado === 'S' ?
                                                <>  <Button style={{ backgroundColor: '#1E8449' }} onClick={() => alertaenviar(pedido.idpedidos)}>Confirmar envio</Button>&nbsp;
                                                </>
                                                : <><ListGroupItem>
                                                    <p style={{ fontSize: "22px", textAlign: "center", color: "black" }}>.....</p>
                                                </ListGroupItem></>
                                        }
                                    </Card>

                                </Col>

                            );

                        })}   <br /><br /><br /> </Row> <br /><br /><br />
                </div>
            </>
        );
    }
}

export default dashboardAdmin;