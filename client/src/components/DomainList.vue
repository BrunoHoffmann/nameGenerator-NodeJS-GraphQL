<template>
	<div id="main">
		<div class="container">
			<div class="row">
				<div class="col-md">
					<app-item-list :items="prefixes" v-on:addItem="addPrefix" v-on:deleteItem="deletePrefix" title="Prefixos"></app-item-list>
				</div>

				<div class="col-md">
					<app-item-list :items="sufixes" v-on:addItem="addSufix" v-on:deleteItem="deleteSufix" title="Sufixos"></app-item-list>
				</div>
			</div>
			<br>
			<h5>Domínios <span class="badge badge-info">{{domains.length}}</span></h5>
			<div class="card">
				<div class="card-body">
					<div class="list-group">
						<li class="list-group-item" v-for="domain in domains" :key="domain.name">
							<div class="row">
								<div class="col-md">
									{{domain.name}}
								</div>
								<div class="col-md text-right">
									<a :href="domain.checkout" target="_blank" class="btn btn-info"><span class="fa fa-shopping-cart"></span></a>
								</div>
							</div>
						</li>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>

import axios from "axios/dist/axios";
import AppItemList from "./AppItemList";

export default {
	name: "app",
	components: {
		AppItemList
	},
	data() {
		return {
			prefixes: [],
			sufixes: [],
		};
	},
	methods: {
		addPrefix(prefix) {
			this.prefixes.push(prefix);
		},
		deletePrefix(prefix) {
			this.prefixes.splice(this.prefixes.indexOf(prefix), 1);
		},
		addSufix(sufix) {
			this.sufixes.push(sufix);
		},
		deleteSufix(sufix) {
			this.sufixes.splice(this.sufixes.indexOf(sufix), 1);
		}
	},
	computed: {
		domains() {
			console.log("teste");
			const domains = [];
			for (const prefix of this.prefixes) {
				for (const sufix of this.sufixes) {
					const name = prefix + sufix;
					const url = name.toLowerCase();
					const checkout = `https://checkout.hostgator.com.br/?a=add&sld=${url}&tld=.com.br`;
					domains.push({
						name,
						checkout
					});
				}
			}
			return domains;
		}
	},
	created() {
		axios({
			url: "http://localhost:4000",
			method: "post",
			data: {
				query: `
					{
						items (type: "prefix") {
							id
							type
							description
						}
					}
				`
			}
		}).then(response => {
			const query = response.data;
			this.prefixes = query.data.prefixes.map(prefix => prefix.description);
			this.sufixes = query.data.sufixes.map(sufix => sufix.description);
		});
	}
};
</script>

<style>
</style>
