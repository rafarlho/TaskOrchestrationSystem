export interface ConfigSettings {
    api:API
    auth0: Auth0
}

export interface API {
    tosAPI:string
}

export interface Auth0 {
    clientId:string
    domain:string
    audience:string
}
