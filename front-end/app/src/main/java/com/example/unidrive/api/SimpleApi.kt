package com.example.unidrive.api

import retrofit2.http.GET

interface SimpleApi {

    @GET("profile/1")
    suspend fun getProfile(): Post
}